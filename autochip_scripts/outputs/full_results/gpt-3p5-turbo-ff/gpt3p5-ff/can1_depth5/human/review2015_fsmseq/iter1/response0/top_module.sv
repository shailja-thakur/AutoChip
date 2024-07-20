module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);
    reg [3:0] state;
    parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4;

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= S0;
        else begin
            case (state)
                S0: begin
                    if (data) begin
                        state <= S1;
                    end else begin
                        state <= S0;
                    end
                end
                S1: begin
                    if (data) begin
                        state <= S2;
                    end else begin
                        state <= S0;
                    end
                end
                S2: begin
                    if (data) begin
                        state <= S3;
                    end else begin
                        state <= S0;
                    end
                end
                S3: begin
                    if (data) begin
                        start_shifting <= 1;
                        state <= S4;
                    end else begin
                        state <= S0;
                    end
                end
                S4: begin
                    if (!data) begin
                        state <= S0;
                    end else begin
                        state <= S4;
                    end
                end
                default: state <= S0;
            endcase
        end
    end

endmodule
