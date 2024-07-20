module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    reg [1:0] state, next_state;
    reg [23:0] message;
    reg valid_message;

    localparam WAIT = 2'b00, BYTE1 = 2'b01, BYTE2 = 2'b10, BYTE3 = 2'b11;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= WAIT;
            out_bytes <= 24'b0;
            done <= 0;
            message <= 24'b0;
            valid_message <= 0;
        end else begin
            state <= next_state;
            if (done) begin
                out_bytes <= message;
                message <= 24'b0;
                valid_message <= 0;
            end else if (state == BYTE3) begin
                message <= {message[15:0], in};
                valid_message <= 1;
            end else if (state == BYTE1 || state == BYTE2) begin
                message <= {message[15:0], in};
            end
        end
    end

    always @(*) begin
        out_bytes = 24'b0;
        done = 0;
        case (state)
            WAIT: begin
                if (in[3]) begin
                    next_state = BYTE1;
                end else begin
                    next_state = WAIT;
                end
            end

            BYTE1: begin
                next_state = BYTE2;
            end

            BYTE2: begin
                next_state = BYTE3;
            end

            BYTE3: begin
                next_state = WAIT;
                done = 1;
                out_bytes = message;
            end

            default: begin
                next_state = WAIT;
            end
        endcase
    end

endmodule
