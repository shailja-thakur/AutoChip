module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // Define states using local parameters for readability
    localparam STATE_A = 2'd0,
               STATE_B = 2'd1,
               STATE_C = 2'd2,
               STATE_D = 2'd3;
               
    // State register
    reg [1:0] state, next_state;
    
    // State transition logic
    always @(*) begin
        case (state)
            STATE_A: begin
                if (in)
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
                out = 1'b0;
            end
            STATE_B: begin
                if (in)
                    next_state = STATE_B;
                else
                    next_state = STATE_C;
                out = 1'b0;
            end
            STATE_C: begin
                if (in)
                    next_state = STATE_D;
                else
                    next_state = STATE_A;
                out = 1'b0;
            end
            STATE_D: begin
                if (in)
                    next_state = STATE_B;
                else
                    next_state = STATE_C;
                out = 1'b1;
            end
            default: begin
                next_state = STATE_A; // default state
                out = 1'b0;
            end
        endcase
    end
    
    // State register update logic
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= STATE_A;
        else
            state <= next_state;
    end

endmodule
