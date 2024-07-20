module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    // State encoding
    reg state, next_state;

    // State assignments for one-hot encoding
    localparam A = 1'b0;
    localparam B = 1'b1;

    // State transition and output logic
    always @(*) begin
        case (state)
            A: begin
                if (x == 1'b0) begin
                    next_state = A;
                    z = 1'b0;
                end else begin
                    next_state = B;
                    z = 1'b1;
                end
            end
            B: begin
                if (x == 1'b0) begin
                    next_state = B;
                    z = 1'b1;
                end else begin
                    next_state = B;
                    z = 1'b0;
                end
            end
            default: begin
                next_state = A;
                z = 1'b0;
            end
        endcase
    end
    
    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end
endmodule
