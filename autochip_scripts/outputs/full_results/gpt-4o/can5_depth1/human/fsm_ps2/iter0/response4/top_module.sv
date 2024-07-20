module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);
    reg [1:0] state, next_state;
    reg [1:0] count;

    // States
    localparam IDLE = 2'b00;
    localparam BYTE1 = 2'b01;
    localparam BYTE2 = 2'b10;
    localparam BYTE3 = 2'b11;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            count <= 2'b00;
            done <= 1'b0;
        end else begin
            state <= next_state;
            if(state == BYTE1 || state == BYTE2) begin
                count <= count + 2'b01;
            end else begin
                count <= 2'b00;
            end

            if(state == BYTE3) begin
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end
        end
    end

    always @(*) begin
        case (state)
            IDLE: begin
                if (in[3] == 1'b1) begin
                    next_state = BYTE1;
                end else begin
                    next_state = IDLE;
                end
            end
            BYTE1: begin
                next_state = BYTE2;
            end
            BYTE2: begin
                next_state = BYTE3;
            end
            BYTE3: begin
                next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end

endmodule
