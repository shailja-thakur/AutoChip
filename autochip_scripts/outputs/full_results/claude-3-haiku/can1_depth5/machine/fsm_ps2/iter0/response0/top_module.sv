module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

localparam BYTE1 = 2'b00;
localparam BYTE2 = 2'b01;
localparam BYTE3 = 2'b10;
localparam DONE  = 2'b11;

reg [1:0] current_state, next_state;

always @(posedge clk or negedge reset) begin
    if (!reset) begin
        current_state <= BYTE1;
    end else begin
        current_state <= next_state;
    end
end

always @(*) begin
    case (current_state)
        BYTE1: begin
            done = 1'b0;
            if (in[2]) begin
                next_state = BYTE2;
            end else begin
                next_state = BYTE1;
            end
        end
        BYTE2: begin
            done = 1'b0;
            next_state = BYTE3;
        end
        BYTE3: begin
            done = 1'b0;
            next_state = DONE;
        end
        DONE: begin
            done = 1'b1;
            if (in[2]) begin
                next_state = BYTE2;
            end else begin
                next_state = BYTE1;
            end
        end
        default: begin
            done = 1'b0;
            next_state = BYTE1;
        end
    endcase
end

endmodule
