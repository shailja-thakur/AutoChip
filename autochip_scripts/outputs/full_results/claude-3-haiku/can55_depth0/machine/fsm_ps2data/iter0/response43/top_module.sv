module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

localparam BYTE1 = 2'b00;
localparam BYTE2 = 2'b01;
localparam BYTE3 = 2'b10;
localparam DONE = 2'b11;

reg [1:0] state, next_state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= BYTE1;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        BYTE1: begin
            if (in[2]) begin
                next_state = BYTE2;
            end
            else begin
                next_state = BYTE1;
            end
        end
        BYTE2: begin
            next_state = BYTE3;
        end
        BYTE3: begin
            next_state = DONE;
        end
        DONE: begin
            if (in[2]) begin
                next_state = BYTE1;
            end
            else begin
                next_state = DONE;
            end
        end
        default: begin
            next_state = BYTE1;
        end
    endcase
end

always @(posedge clk) begin
    if (state == BYTE1) begin
        out_bytes <= {out_bytes[15:0], in};
    end
    else if (state == BYTE2) begin
        out_bytes <= {out_bytes[15:0], in};
    end
    else if (state == BYTE3) begin
        out_bytes <= {out_bytes[15:0], in};
    end
    if (state == DONE) begin
        done <= 1'b1;
    end
    else begin
        done <= 1'b0;
    end
end

endmodule
