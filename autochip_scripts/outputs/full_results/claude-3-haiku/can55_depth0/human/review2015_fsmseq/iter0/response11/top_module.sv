module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

localparam IDLE = 2'b00;
localparam SEQ1 = 2'b01;
localparam SEQ2 = 2'b10;
localparam SEQ3 = 2'b11;

reg [1:0] state, next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        start_shifting <= 1'b0;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    next_state = state;
    case (state)
        IDLE: begin
            if (data == 1'b1)
                next_state = SEQ1;
            else
                next_state = IDLE;
        end
        SEQ1: begin
            if (data == 1'b1)
                next_state = SEQ2;
            else
                next_state = IDLE;
        end
        SEQ2: begin
            if (data == 1'b0)
                next_state = SEQ3;
            else
                next_state = IDLE;
        end
        SEQ3: begin
            if (data == 1'b1) begin
                next_state = SEQ1;
                start_shifting <= 1'b1;
            end
            else begin
                next_state = IDLE;
            end
        end
    endcase
end

endmodule
