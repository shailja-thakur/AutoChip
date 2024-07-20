module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // States
    reg [1:0] state;
    parameter A = 2'b00;
    parameter B = 2'b01;

    // Outputs
    assign z = (state == B) ? 1'b1 : 1'b0;

    // Next state logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A;
        end else begin
            case(state)
                A: begin
                    if (x) begin
                        state <= B;
                    end else begin
                        state <= A;
                    end
                end
                B: begin
                    if (!x) begin
                        state <= B;
                    end else begin
                        state <= B;
                    end
                end
                default: begin
                    state <= A;
                end
            endcase
        end
    end
endmodule
