module top_module (
    input clk,
    input reset,        // Synchronous active-high reset
    output [3:0] q);

    reg [3:0] count;
    reg [1:0] state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 0;
            state <= 0;
        end else begin
            if (state == 0) begin
                count <= count + 1;
                if (count == 10) begin
                    count <= 0;
                    state <= 1;
                end
            end else begin
                state <= 0;
            end
        end
    end

    assign q = count;

endmodule