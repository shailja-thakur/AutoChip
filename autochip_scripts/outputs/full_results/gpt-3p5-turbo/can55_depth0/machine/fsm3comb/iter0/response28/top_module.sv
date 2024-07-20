module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output reg out
);

always_comb begin
    case (state)
        2'd0: begin // state A
            if (in)
                next_state = 2'd1; // transition to state B
            else
                next_state = 2'd0; // remain in state A
        end
        
        2'd1: begin // state B
            if (in)
                next_state = 2'd1; // remain in state B
            else
                next_state = 2'd2; // transition to state C
        end
        
        2'd2: begin // state C
            if (in)
                next_state = 2'd3; // transition to state D
            else
                next_state = 2'd0; // transition to state A
        end
        
        2'd3: begin // state D
            if (in)
                next_state = 2'd1; // transition to state B
            else
                next_state = 2'd2; // transition to state C
        end
    endcase
end

always @(posedge clk) begin
    if (state == 2'd3) // state D
        out <= 1'b1;
    else
        out <= 1'b0;
end

endmodule
