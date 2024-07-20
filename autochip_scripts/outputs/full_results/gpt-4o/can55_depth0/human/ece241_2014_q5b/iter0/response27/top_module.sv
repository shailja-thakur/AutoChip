module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State encoding using one-hot encoding
    reg [1:0] state, next_state;
    localparam A = 2'b01, B = 2'b10;

    // State transition
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

    // Update state on clock edge
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end
endmodule
