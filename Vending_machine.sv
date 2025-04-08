module Vending_machine(
	input logic clk,
	input logic rs,
	input logic nickle,
	input logic dime,
	input logic quarter,
	output logic s,
	output logic [2:0]c);
	
	typedef enum logic [3:0] {S0,S5,S10,S15,S20,S25,S30,S35,S40} state;
	state current, next;
	logic [4:0]coin;
	
	always_comb begin
		case(current)
		S0: begin
			if(!(nickle|dime|quarter)) next = current;
			else if(nickle) 	 next = S5;
			else if(dime) 	 next = S10;
			else 			 next = S25;
		end
		S5: begin
			if(!(nickle|dime|quarter)) next = current;
			else if(nickle) 	 next = S10;
			else if(dime) 	 next = S15;
			else 			 next = S30;
		end
		S10: begin
			if(!(nickle|dime|quarter)) next = current;
			else if(nickle) 	 next = S15;
			else if(dime) 	 next = S20;
			else 			 next = S35;
		end
		S15: begin
			if(!(nickle|dime|quarter)) next = current;
			else if(nickle) 	 next = S20;
			else if(dime) 	 next = S25;
			else 			 next = S40;
		end
		S20: 				 next = S0;
		S25: 				 next = S0;
		S30: 				 next = S0;
		S35: 				 next = S0;
		S40: 				 next = S0;
		default next = S0;
		endcase
	end
	
	always_ff @(posedge clk) begin
     current <= next;
	end

	always_comb begin
	 if(!rs) begin
		 case(current)
			S0: begin
				s = 1'b0;
				c = 3'b000;
			end
			S5: begin
				s = 1'b0;
				c = 3'b001;
			end
			S10: begin
				s = 1'b0;
				c = 3'b010;
			end
			S15: begin
				s = 1'b0;
				c = 3'b011;
			end
			default begin
				s = 1'b0;
				c = 3'b000;
			end
		 endcase
	end
	 
	 else begin
	 case(current)
		S0: begin
			s = 1'b0;
			c = 3'b000;
		end
		S5: begin
			s = 1'b0;
			c = 3'b000;
		end
		S10: begin
			s = 1'b0;
			c = 3'b000;
		end
		S15: begin
			s = 1'b0;
			c = 3'b000;
		end
		S20: begin
			s = 1'b1;
			c = 3'b000;
		end
		S25: begin
			s = 1'b1;
			c = 3'b001;
		end
		S30: begin
			s = 1'b1;
			c = 3'b010;
		end
		S35: begin
			s = 1'b1;
			c = 3'b011;
		end
		S40: begin
			s = 1'b1;
			c = 3'b100;
		end
		default begin 
			s = 1'b0;
			c = 3'b000;
		end
		endcase
		end
	end
	
endmodule
