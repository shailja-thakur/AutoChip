module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

reg [2:0] state;
reg [7:0] first_byte;
reg [7:0] second_byte;
reg [7:0] third_byte;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 0;
        first_byte <= 0;
        second_byte <= 0;
        third_byte <= 0;
    end else begin
        case (state)
            0: begin
                if (in[3] == 1) begin
                    first_byte <= in;
                    state <= 1;
                end
            end
            1: begin
                second_byte <= in;
                state <= 2;
            end
            2: begin
                third_byte <= in;
                state <= 0;
                done <= 1;
            end
        endcase
    end
end

endmodule
