module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack
);

reg [3:0] state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 0;
        shift_ena <= 0;
    end else begin
        case (state)
            0: begin
                if (data == 1 && $past(data) == 1 && $past($past(data)) == 0 && $past($past($past(data))) == 1) begin
                    state <= 1;
                end else begin
                    state <= 0;
                end
                shift_ena <= 0;
                counting <= 0;
                done <= 0;
            end
            1: begin
                shift_ena <= 1;
                state <= 2;
            end
            2: begin
                shift_ena <= 0;
                counting <= 1;
                if (done_counting) begin
                    state <= 3;
                end else begin
                    state <= 2;
                end
            end
            3: begin
                done <= 1;
                if (ack) begin
                    state <= 0;
                end else begin
                    state <= 3;
                end
            end
        endcase
    end
end

endmodule
