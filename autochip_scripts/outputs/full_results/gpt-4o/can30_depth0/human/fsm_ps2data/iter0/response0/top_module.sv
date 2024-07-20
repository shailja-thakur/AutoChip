module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    reg [1:0] state, next_state;
    reg [23:0] message;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= 2'b00;
            message <= 24'b0;
            out_bytes <= 24'b0;
            done <= 1'b0;
        end else begin
            state <= next_state;
            if (state == 2'b01 || state == 2'b10) begin
                message <= {message[15:0], in};
            end
        end
    end

    always @(*) begin
        next_state = state;
        done = 1'b0;

        case (state)
            2'b00: begin // waiting for first byte with in[3]=1
                if (in[3]) begin
                    next_state = 2'b01;
                    message = {16'b0, in};
                end
            end
            2'b01: begin // received first byte
                next_state = 2'b10;
            end
            2'b10: begin // received second byte
                next_state = 2'b11;
            end
            2'b11: begin // received third byte, signal done
                done = 1'b1;
                out_bytes = message;
                if (in[3]) begin
                    next_state = 2'b01;
                    message = {16'b0, in};
                end else begin
                    next_state = 2'b00;
                end
            end
        endcase
    end
endmodule
