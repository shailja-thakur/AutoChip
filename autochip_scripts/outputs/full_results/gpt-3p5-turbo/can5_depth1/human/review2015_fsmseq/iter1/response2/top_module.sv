module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);


    reg [3:0] state;
    reg [3:0] prev_state;
    reg prev_data;

    assign start_shifting = (state == 3);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 0;
            prev_state <= 0;
            prev_data <= 0;
        end else begin
            case (state)
                0: begin
                    if (prev_state == 2 && prev_data == 1 && data == 1)
                        state <= 3;
                    else if (data == 1)
                        state <= 1;
                    else
                        state <= 0;
                end
                1: begin
                    if (data == 1)
                        state <= 2;
                    else
                        state <= 0;
                end
                2: begin
                    if (data == 1)
                        state <= 2;
                    else
                        state <= 0;
                end
                3: begin
                    state <= 3;
                end
                default: state <= 0;
            endcase

            prev_state <= state;
            prev_data <= data;
        end
    end
endmodule
