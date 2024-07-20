module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

reg [1:0] state;
reg [23:0] register;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 2'b00;
        register <= 24'b0;
        done <= 0;
    end else begin
        case (state)
            2'b00:
                if (in[2] == 1'b1)
                    state <= 2'b01;
                else
                    state <= 2'b00;
            2'b01:
                if (in[2] == 1'b1)
                    state <= 2'b10;
                else
                    state <= 2'b00;
            2'b10:
                if (in[2] == 1'b1)
                    state <= 2'b11;
                else
                    state <= 2'b00;
            2'b11:
                state <= 2'b00;
        endcase
        
        if (state == 2'b00 && in[2] == 1'b0)
            state <= 2'b00;
        
        if (state == 2'b11 && in[2] == 1'b0)
            state <= 2'b00;
    end
end

always @(posedge clk) begin
    if (done)
        out_bytes <= register;
    
    register <= {register[15:0], in};
end

always @(state) begin
    if (state == 2'b11)
        done <= 1;
    else
        done <= 0;
end

endmodule
