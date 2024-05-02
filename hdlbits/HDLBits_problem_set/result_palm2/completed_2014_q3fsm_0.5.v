module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);

    reg [1:0] state;
    reg z;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 0;
        end else begin
            if (s) begin
                state <= 1;
            end else begin
                if (w == 1) begin
                    if (state == 0) begin
                        state <= 1;
                    elsif (state == 1) begin
                        state <= 2;
                    elsif (state == 2) begin
                        state <= 0;
                        z <= 1;
                    end
                end
            end
        end
    end

endmodule