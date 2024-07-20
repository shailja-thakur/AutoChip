module top_module (
	input wire clk,
    input wire [7:0] in,
    input wire reset,
    output wire [23:0] out_bytes,
    output wire done
);
 
reg [2:0] state;
reg [23:0] register;
  
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= BYTE1;
        register <= 0;
        done <= 0;
    end else begin
        case (state)
            BYTE1: begin
                if (in[2]) begin
                    state <= BYTE2;
                end else begin
                    state <= BYTE1;
                end
            end

            BYTE2: begin
                state <= BYTE3;
            end

            BYTE3: begin
                state <= DONE;
            end

            DONE: begin
                if (in[2]) begin
                    state <= BYTE1;
                end else begin
                    state <= BYTE1;
                end
            end
        endcase

        if (state == DONE) begin
            done <= 1;
            out_bytes <= register;
        end else begin
            done <= 0;
        end
   
        register <= {register[15:0], in};
    end
end

endmodule
