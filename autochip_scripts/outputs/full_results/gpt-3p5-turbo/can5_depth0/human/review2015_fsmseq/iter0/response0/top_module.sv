module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    reg [1:0] state;
    reg [3:0] shift_register;

    always @(posedge clk) begin
        if (reset) begin
            state <= 0;
            shift_register <= 0;
            start_shifting <= 0;
        end else begin
            case (state)
                0: begin
                    if (data == 1'b1)
                        state <= 1;
                end
                1: begin
                    if (data == 1'b1)
                        state <= 2;
                    else
                        state <= 0;
                end
                2: begin
                    if (data == 1'b0)
                        state <= 3;
                    else
                        state <= 0;
                end
                3: begin
                    if (data == 1'b1) begin
                        state <= 4;
                        start_shifting <= 1;
                    end else begin
                        state <= 0;
                        start_shifting <= 0;
                    end
                end
                4: begin
                    state <= 4;
                end
            endcase
        end
    end

endmodule
