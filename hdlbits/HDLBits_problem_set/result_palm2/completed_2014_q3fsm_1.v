module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);

    always @(posedge clk) begin
        if (reset) begin
            state <= '0;
        end else begin
            if (s) begin
                state <= '1;
            end else if (state == '1) begin
                if (w == 1) begin
                    if (state_cnt == 2) begin
                        state <= '2;
                        z <= 1;
                    end
                    state_cnt <= state_cnt + 1;
                else begin
                    state_cnt <= 0;
                end
            end else begin
                state_cnt <= 0;
            end
        end
    end

    reg [1:0] state;
    reg [3:0] state_cnt;

endmodule