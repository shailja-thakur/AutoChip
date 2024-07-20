module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State encoding using one-hot method
    parameter A = 2'b01,
              B = 2'b10;

    reg [1:0] state, next_state;

    // State transition logic (combinational)
    always @(*) begin
        case (state)
            A: if (x) begin
                   next_state = B;
                   z = 1;
               end else begin
                   next_state = A;
                   z = 0;
               end
            B: if (x) begin
                   next_state = B;
                   z = 0;
               end else begin
                   next_state = B;
                   z = 1;
               end
            default: begin
                next_state = A;
                z = 0;
            end
        endcase
    end

    // State flip-flops with asynchronous reset (sequential)
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

endmodule
