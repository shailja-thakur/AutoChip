module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    typedef enum reg [1:0] {
        BYTE1 = 2'b00,
        BYTE2 = 2'b01,
        BYTE3 = 2'b10,
        DONE  = 2'b11
    } state_t;

    reg [1:0] state, next_state;
    reg [23:0] out_bytes_temp;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= BYTE1;
            out_bytes_temp <= 24'b0;
        end else begin
            state <= next_state;
            if (state != DONE || (state == DONE && !done)) begin
                out_bytes_temp <= {out_bytes_temp[15:0], in};
            end
        end
    end

    always @(*) begin
        next_state = state;
        done = 1'b0;
        case (state)
            BYTE1:
                if (in[3] == 1'b1)
                    next_state = BYTE2;
                else
                    next_state = BYTE1;
            BYTE2:
                next_state = BYTE3;
            BYTE3:
                next_state = DONE;
            DONE:
                if (in[3] == 1'b0)
                    next_state = BYTE1;
                else
                    next_state = DONE;
        endcase
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            out_bytes <= 24'b0;
        end else begin
            if (state == DONE)
                out_bytes <= out_bytes_temp;
            else
                out_bytes <= 24'b0;
        end
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            done <= 1'b0;
        end else if (state == DONE) begin
            done <= 1'b1;
        end else begin
            done <= 1'b0;
        end
    end
    
endmodule
