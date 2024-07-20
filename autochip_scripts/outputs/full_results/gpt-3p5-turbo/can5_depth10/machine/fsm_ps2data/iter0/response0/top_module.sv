module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output [23:0] out_bytes,
    output done
);

    reg [23:0] out_reg;
    reg [1:0] state;
    reg done_reg;

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 2'b00;
        else begin
            case (state)
                2'b00: begin
                    if (in[2] == 1)
                        state <= 2'b01;
                    else
                        state <= 2'b00;
                end

                2'b01: begin
                    if (in[2] == 1)
                        state <= 2'b10;
                    else
                        state <= 2'b00;
                end

                2'b10: begin
                    if (in[2] == 1)
                        state <= 2'b11;
                    else
                        state <= 2'b00;
                end

                2'b11: begin
                    if (in[2] == 0)
                        state <= 2'b00;
                end
            endcase
        end
    end

    always @(posedge clk) begin
        if (state == 2'b11)
            done_reg <= 1'b1;
        else
            done_reg <= 1'b0;

        if (done_reg)
            out_bytes <= out_reg;
        
        out_reg <= {out_reg[15:0], in};
    end

    assign done = done_reg;
    
endmodule
