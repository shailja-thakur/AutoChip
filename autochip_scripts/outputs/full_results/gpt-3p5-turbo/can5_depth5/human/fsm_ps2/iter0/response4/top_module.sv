module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

    reg [2:0] state;
    reg done_temp;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 0;
            done_temp <= 0;
        end else begin
            case (state)
                0: begin
                    if (in[3] == 1) begin
                        state <= 1;
                    end
                end
                1: begin
                    state <= 2;
                end
                2: begin
                    if (in[3] == 1) begin
                        done_temp <= 1;
                        state <= 0;
                    end else begin
                        state <= 1;
                    end
                end
                default: state <= 0;
            endcase
        end
    end

    assign done = done_temp;

endmodule
