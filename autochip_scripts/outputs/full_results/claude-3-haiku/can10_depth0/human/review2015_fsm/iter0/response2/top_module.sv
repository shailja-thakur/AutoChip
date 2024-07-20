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

reg [1:0] state, next_state;
reg [3:0] bit_count;

localparam [1:0]
    SEARCH = 2'b00,
    SHIFT  = 2'b01,
    COUNT  = 2'b10,
    DONE   = 2'b11;

always @(posedge clk) begin
    if (reset)
        state <= SEARCH;
    else
        state <= next_state;
end

always @* begin
    next_state = state;
    shift_ena = 1'b0;
    counting  = 1'b0;
    done      = 1'b0;

    case (state)
        SEARCH: begin
            if (data == 1'b1) begin
                bit_count <= 4'b1;
            end else if (bit_count == 4'b1101) begin
                next_state = SHIFT;
                bit_count  = 4'b0;
            end else if (bit_count != 4'b0) begin
                bit_count <= bit_count + 1;
            end
        end

        SHIFT: begin
            shift_ena = 1'b1;
            if (bit_count == 4'b0100) begin
                next_state = COUNT;
            end else begin
                bit_count <= bit_count + 1;
            end
        end

        COUNT: begin
            counting = 1'b1;
            if (done_counting) begin
                next_state = DONE;
            end
        end

        DONE: begin
            done = 1'b1;
            if (ack) begin
                next_state = SEARCH;
            end
        end
    endcase
end

endmodule
