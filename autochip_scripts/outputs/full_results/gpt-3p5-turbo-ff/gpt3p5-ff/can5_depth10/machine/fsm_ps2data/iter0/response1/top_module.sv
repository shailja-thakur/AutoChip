module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

typedef enum logic [1:0] {BYTE1, BYTE2, BYTE3, DONE} state_type;
reg [1:0] state;
reg [7:0] register;

always @(posedge clk) begin
    if (reset) begin
        state <= BYTE1;
        register <= 0;
        done <= 0;
    end else begin
        case (state)
            BYTE1: begin
                if (in[2] == 1) begin
                    state <= BYTE2;
                end else begin
                    state <= BYTE1;
                end
                register <= in;
            end
            BYTE2: begin
                if (in[2] == 1) begin
                    state <= BYTE3;
                end else begin
                    state <= BYTE1;
                end
                register <= in;
            end
            BYTE3: begin
                if (in[2] == 1) begin
                    state <= DONE;
                end else begin
                    state <= BYTE1;
                end
                register <= in;
            end
            DONE: begin
                if (in[2] == 0) begin
                    state <= BYTE1;
                end else begin
                    state <= DONE;
                end
                register <= in;
            end
        endcase
    end
end

always @(posedge clk) begin
    if (reset) begin
        out_bytes <= 0;
    end else begin
        if (done) begin
            out_bytes <= register;
        end else begin
            out_bytes <= {register[15:0], register[23:16]};
        end
    end
end

always @(posedge clk) begin
    if (reset) begin
        done <= 0;
    end else begin
        if (state == DONE) begin
            done <= 1;
        end else begin
            done <= 0;
        end
    end
end

endmodule
