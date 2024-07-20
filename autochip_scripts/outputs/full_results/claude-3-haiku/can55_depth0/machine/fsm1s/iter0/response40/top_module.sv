module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    parameter A = 0, B = 1;
    reg [0:0] state;

    always @(posedge clk) begin
        if (reset) begin
            state <= B; // Reset state to B
        end else begin
            case (state)
                A: begin
                    if (in) begin
                        state <= A;
                    end else begin
                        state <= B;
                    end
                end
                B: begin
                    if (in) begin
                        state <= B;
                    end else begin
                        state <= A;
                    end
                end
            endcase
        end
    end

    assign out = (state == B); // Output high when state is B

endmodule
