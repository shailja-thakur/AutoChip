module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

localparam WAIT_FOR_MSG = 2'b00;
localparam READ_MSG_1 = 2'b01;
localparam READ_MSG_2 = 2'b10;
localparam READ_MSG_3 = 2'b11;

reg [1:0] state;
reg [1:0] next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_FOR_MSG;
        done <= 1'b0;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        WAIT_FOR_MSG: begin
            if (in[3]) begin
                next_state = READ_MSG_1;
                done = 1'b0;
            end
            else begin
                next_state = WAIT_FOR_MSG;
                done = 1'b0;
            end
        end
        READ_MSG_1: begin
            next_state = READ_MSG_2;
            done = 1'b0;
        end
        READ_MSG_2: begin
            next_state = READ_MSG_3;
            done = 1'b0;
        end
        READ_MSG_3: begin
            next_state = WAIT_FOR_MSG;
            done = 1'b1;
        end
        default: begin
            next_state = WAIT_FOR_MSG;
            done = 1'b0;
        end
    endcase
end

endmodule
