module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

reg [1:0] state;

always @(posedge clk) begin
    if(reset) begin
        state <= BYTE1;
        out_bytes <= 0;
        done <= 0;
    end
    else begin
        case(state)
            BYTE1: begin
                if(in[2] == 1)
                    state <= BYTE2;
                else
                    state <= BYTE1;
            end
            
            BYTE2: begin
                if(in[2] == 1)
                    state <= BYTE3;
                else
                    state <= BYTE1;
            end
            
            BYTE3: begin
                if(in[2] == 1)
                    state <= DONE;
                else
                    state <= BYTE1;
            end
            
            DONE: begin
                if(in[2] == 0)
                    state <= BYTE1;
                else
                    state <= DONE;
            end
        endcase
    end
end

always @(posedge clk) begin
    if(done) begin
        out_bytes <= in;
    end
    else begin
        out_bytes <= {out_bytes[15:0], in};
    end
end

always @(posedge clk) begin
    if(state == DONE)
        done <= 1;
    else
        done <= 0;
end

endmodule
