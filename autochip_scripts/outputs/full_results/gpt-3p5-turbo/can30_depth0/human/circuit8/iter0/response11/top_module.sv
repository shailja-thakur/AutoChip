module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);
    reg state;
    
    always @(posedge clock) begin
        case (state)
            0: begin
                if (a == 1'b1)
                    state <= 1;
            end
            1: begin
                p <= 1;
                state <= 2;
            end
            2: begin
                if (a == 1'b0)
                    state <= 3;
            end
            3: begin
                q <= 1;
                state <= 4;
            end
            4: begin
                if (a == 1'b1)
                    state <= 5;
            end
            5: begin
                if (a == 1'b0)
                    state <= 6;
            end
            6: begin
                q <= 0;
                state <= 7;
            end
            7: begin
                p <= 0;
                state <= 0;
            end
            default: state <= 0;
        endcase
    end
    
endmodule
