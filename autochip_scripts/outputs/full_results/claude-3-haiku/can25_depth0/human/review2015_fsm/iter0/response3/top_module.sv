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

localparam [3:0] SEARCH = 4'd0, SHIFT = 4'd1, COUNT = 4'd2, NOTIFY = 4'd3;
reg [3:0] state, next_state;
reg [3:0] shift_count;

always @(posedge clk) begin
    if (reset) begin
        state <= SEARCH;
        shift_count <= 4'd0;
        shift_ena <= 1'b0;
        counting <= 1'b0;
        done <= 1'b0;
    end
    else begin
        state <= next_state;
        case (state)
            SEARCH: begin
                if (data == 1'b1 && shift_count == 4'd0) shift_count <= 4'd1;
                else if (data == 1'b1 && shift_count == 4'd1) shift_count <= 4'd2;
                else if (data == 1'b0 && shift_count == 4'd2) shift_count <= 4'd3;
                else if (data == 1'b1 && shift_count == 4'd3) begin
                    shift_count <= 4'd0;
                    next_state <= SHIFT;
                end
                else shift_count <= 4'd0;
            end
            SHIFT: begin
                shift_ena <= 1'b1;
                if (shift_count == 4'd4) begin
                    shift_ena <= 1'b0;
                    next_state <= COUNT;
                end
                else shift_count <= shift_count + 4'd1;
            end
            COUNT: begin
                counting <= 1'b1;
                if (done_counting) begin
                    counting <= 1'b0;
                    next_state <= NOTIFY;
                end
            end
            NOTIFY: begin
                done <= 1'b1;
                if (ack) begin
                    done <= 1'b0;
                    next_state <= SEARCH;
                end
            end
        endcase
    end
end

endmodule
