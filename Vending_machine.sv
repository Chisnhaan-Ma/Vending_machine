module Vending_machine(
	input logic clk,
	input logic nickel,
	input logic dime,
	input logic quarter,
	output logic soda,
	output logic [2:0]change);
	
	localparam IDLE = 2'b00;
	localparam WAIT = 2'b01;
	localparam REC = 2'b10;
	
	logic [5:0] coin;
	logic [1:0] current;
	logic	[1:0] next;
	
always_comb begin
	case (current)
		IDLE: begin
			if ((nickel || dime || quarter) == 0) next = current;
			else if (quarter) next = REC;
			else next = WAIT;
		end
		
		WAIT: begin
			if (coin >= 6'd20) next = REC;
			else next = current;
		end
		
		REC: begin
			next = IDLE;
		end
		
		default: next = IDLE;
		
	endcase
	
end	

always_ff @ ( posedge clk ) begin
	current <= next;
	case (current)
		IDLE: begin
			coin <= 1'b0;
			soda <= 1'b0;
			change <= 3'b0;
		end
		
		WAIT: begin
			if (nickel) 	coin <= coin + 6'd5;
			else 				coin <= coin + 6'd10;
		end
		
		REC: begin
			soda <= 1'b1;
			case (coin)
				6'd20: change <= 3'b000;
				6'd25: change <= 3'b001;
				6'd30: change <= 3'b010;
				6'd35: change <= 3'b011;
				6'd40: change <= 3'b100;
			endcase
		end
		
		
	endcase
end
	
endmodule