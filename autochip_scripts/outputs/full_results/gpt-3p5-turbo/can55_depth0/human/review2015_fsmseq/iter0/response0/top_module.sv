module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    reg [3:0] state;
    reg [1:0] count;

    always @(posedge clk) begin
        if (reset)
            state <= 0;
        else begin
            case(state)
                0: if (data == 1)
                       state <= 1;
                   else
                       state <= 0;
                1: if (data == 1)
                       state <= 2;
                   else
                       state <= 0;
                2: if (data == 0)
                       state <= 3;
                   else
                       state <= 0;
                3: if (data == 1) begin
                       state <= 4;
                       count <= 0;
                   end
                   else
                       state <= 0;
                4: if (data == 1) begin
                       count <= count + 1;
                       if (count == 1)
                           start_shifting <= 1;
                       state <= 4;
                   end
                   else begin
                       start_shifting <= 0;
                       state <= 0;
                   end
            endcase
        end
    end
endmodule
