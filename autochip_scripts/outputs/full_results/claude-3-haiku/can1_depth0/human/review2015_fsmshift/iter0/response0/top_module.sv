module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

localparam COUNTER_MAX = 4;

reg [1:0] state;
reg [3:0] counter;

always @(posedge clk) begin
    if (reset) begin
        state <= 0;
        counter <= 0;
        shift_ena <= 1;
    end
    else begin
        case (state)
            0: begin
                shift_ena <= 1;
                counter <= counter + 1;
                if (counter == COUNTER_MAX - 1)
                    state <= 1;
            end
            1: begin
                shift_ena <= 0;
                counter <= 0;
                state <= 1;
            end
        endcase
    end
end

endmodule
