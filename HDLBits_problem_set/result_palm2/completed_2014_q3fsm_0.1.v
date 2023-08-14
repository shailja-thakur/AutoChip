module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);

    reg [1:0] state;
    reg [1:0] next_state;
    reg z;

    always @(posedge clk or negedge reset) begin
        if (reset) begin
            state <= 0;
        end else begin
            case (state)
                2'b00:
                    if (s) begin
                        state <= 2'b01;
                    end else begin
                        state <= 2'b00;
                    end
                2'b01:
                    if (w) begin
                        if (state[0] == 1) begin
                            state <= 2'b10;
                        end else begin
                            state <= 2'b01;
                        end
                    end else begin
                        state <= 2'b00;
                    end
                2'b10:
                    if (w) begin
                        state <= 2'b01;
                    end else begin
                        state <= 2'b10;
                    end
                default:
                    state <= 2'b00;
            endcase
        end

        if (state[1] == 1) begin
            z <= 1;
        end else begin
            z <= 0;
        end
    end

endmodule