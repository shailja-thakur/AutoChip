module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    reg [3:0] state;
    reg [3:0] shift_data;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 0;
            start_shifting <= 0;
        end else begin
            case (state)
                0: begin
                    if (data)
                        state <= 1;
                end
                1: begin
                    if (data)
                        state <= 2;
                    else
                        state <= 0;
                end
                2: begin
                    if (!data)
                        state <= 3;
                    else
                        state <= 0;
                end
                3: begin
                    if (data) begin
                        state <= 0;
                        start_shifting <= 1;
                    end
                end
                default: state <= 0;
            endcase
        end
    end

    always @(posedge clk) begin
        if (start_shifting) begin
            shift_data <= data;
        end
    end

endmodule
