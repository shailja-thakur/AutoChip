module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    reg [1:0] state, next_state;
    reg [23:0] message;
    reg [7:0] byte1, byte2, byte3;

    // State encoding
    localparam IDLE  = 2'b00;
    localparam BYTE1 = 2'b01;
    localparam BYTE2 = 2'b10;
    localparam BYTE3 = 2'b11;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            done <= 0;
            out_bytes <= 24'b0;
        end else begin
            state <= next_state;
            if (state == BYTE3) begin
                out_bytes <= message;
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end
        end
    end

    always @(*) begin
        next_state = state;
        case (state)
            IDLE: begin
                if (in[3]) begin
                    byte1 = in;
                    next_state = BYTE1;
                end
            end
            BYTE1: begin
                byte2 = in;
                next_state = BYTE2;
            end
            BYTE2: begin
                byte3 = in;
                next_state = BYTE3;
            end
            BYTE3: begin
                message = {byte1, byte2, byte3};
                next_state = IDLE;
            end
        endcase
    end
    
    always @(posedge clk) begin
        if (reset) begin
            byte1 <= 8'b0;
            byte2 <= 8'b0;
            byte3 <= 8'b0;
            message <= 24'b0;
        end else begin
            if (state == BYTE1) begin
                byte1 <= in;
            end else if (state == BYTE2) begin
                byte2 <= in;
            end else if (state == BYTE3) begin
                byte3 <= in;
                message <= {byte1, byte2, byte3};
            end
        end
    end

endmodule
