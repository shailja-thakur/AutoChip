module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    reg [3:0] state;

    always @(posedge clk) begin
        if (reset) begin
            state <= 0;
            start_shifting <= 0;
        end else begin
            case (state)
                0: if (data) state <= 1;
                1: if (data) state <= 2; else state <= 0;
                2: if (data) state <= 3; else state <= 0;
                3: if (!data) state <= 0; else begin
                       state <= 4;
                       start_shifting <= 1;
                   end
                4: if (!data) state <= 0;
            endcase
        end
    end

endmodule
