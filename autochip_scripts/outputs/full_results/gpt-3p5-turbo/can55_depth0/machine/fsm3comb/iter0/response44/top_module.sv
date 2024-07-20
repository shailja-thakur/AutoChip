module top_module (
	input in,
	input [1:0] state,
	output reg [1:0] next_state,
	output out
);

always_comb begin
    case(state)
        2'b00: begin // current state is A
            if(in)
                next_state = 2'b01; // next state is B
            else
                next_state = 2'b00; // next state remains A
        end
        2'b01: begin // current state is B
            if(in)
                next_state = 2'b01; // next state remains B
            else
                next_state = 2'b10; // next state is C
        end
        2'b10: begin // current state is C
            if(in)
                next_state = 2'b11; // next state is D
            else
                next_state = 2'b00; // next state is A
        end
        2'b11: begin // current state is D
            if(in)
                next_state = 2'b01; // next state is B
            else
                next_state = 2'b10; // next state is C
        end
    endcase
end

assign out = (state == 2'b11); // out is high when state is D

endmodule
