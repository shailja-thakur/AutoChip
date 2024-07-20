module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);
    
    reg [1:0] state, next_state;
    reg [1:0] byte_count;

    parameter IDLE = 2'b00;
    parameter BYTE1 = 2'b01;
    parameter BYTE2 = 2'b10;
    parameter BYTE3 = 2'b11;
    
    always @ (posedge clk) begin
        if (reset) begin
            state <= IDLE;
            byte_count <= 2'd0;
            done <= 1'b0;
        end else begin
            state <= next_state;
            if (state == BYTE3) begin
                byte_count <= 2'd0;
                done <= 1'b1;
            end else begin
                if (state == BYTE1 || state == BYTE2)
                    byte_count <= byte_count + 1;
                done <= 1'b0;
            end
        end
    end
    
    always @ (*) begin
        next_state = state;
        case (state)
            IDLE: begin
                if (in[3] == 1'b1)
                    next_state = BYTE1;
            end
            BYTE1: begin
                if (byte_count == 2'd1)
                    next_state = BYTE2;
            end
            BYTE2: begin
                if (byte_count == 2'd2)
                    next_state = BYTE3;
            end
            BYTE3: begin
                next_state = IDLE;
            end
        endcase
    end
    
endmodule
