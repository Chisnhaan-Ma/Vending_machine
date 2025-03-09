module Vending_machine(
	input logic clk,
	input logic reset,
	input logic nickel,
	input logic dime,
	input logic quarter,
	output logic soda,
	output logic [2:0] change
);

	localparam IDLE = 2'b00;
	localparam WAIT = 2'b01;
	localparam REC  = 2'b10;

	logic [5:0] coin;
	logic [1:0] current;
	logic [1:0] next;

always_comb begin
	case (current)
		IDLE: begin
			coin = 6'b0;
			soda = 1'b0;
			change = 3'b0;
          	if (!(nickel | dime | quarter)) next = current;
			else if (quarter) next = REC;
			else next = WAIT;
		end
		
		WAIT: begin
          	if (nickel) coin = coin + 6'd5;
            else if (dime) coin = coin + 6'd10;
           	else coin <= coin + 6'd25;
			if (coin >= 6'd20) next = REC;
			else next = current;
		end
		
		REC: begin
          		soda <= 1'b1;
				case (coin)
					6'd20: change = 3'b000;
					6'd25: change = 3'b001;
					6'd30: change = 3'b010;
					6'd35: change = 3'b011;
					6'd40: change = 3'b100;
                  	default change = 3'b000; 
				endcase
				next = IDLE;
		end
		
		default: next = IDLE;
	endcase
end	

  always_ff @ (posedge clk or reset) begin
	if (reset) begin
		current <= IDLE;
	end else begin
		current <= next;
	end
  end


endmodule
