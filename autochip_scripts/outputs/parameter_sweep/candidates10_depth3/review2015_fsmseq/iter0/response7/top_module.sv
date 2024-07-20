module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire start_shifting
);

    reg [3:0] state;

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 4'b0000;
        else begin
            case (state)
                4'b0000: if (data) state <= 4'b0001; else state <= 4'b0000;
                4'b0001: if (data) state <= 4'b0011; else state <= 4'b0000;
                4'b0011: if (data) state <= 4'b0101; else state <= 4'b0001;
                4'b0101: if (data) begin
                                state <= 4'b0000;
                                start_shifting <= 1;
                           end
                           else state <= 4'b0001;
                default: state <= 4'b0000;
            endcase
        end
    end

endmodule
