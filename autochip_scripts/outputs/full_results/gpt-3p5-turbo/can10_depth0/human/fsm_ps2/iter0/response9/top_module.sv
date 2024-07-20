module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

reg [1:0] state;
reg [7:0] byte1;
reg [7:0] byte2;
reg [7:0] byte3;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 0;
        byte1 <= 0;
        byte2 <= 0;
        byte3 <= 0;
    end else begin
        case (state)
            0: begin
                if (in[3] == 1)
                    state <= 1;
                else 
                    state <= 0;
                
                byte1 <= in;
            end
            1: begin
                if (in[3] == 1)
                    state <= 2;
                else 
                    state <= 0;
                
                byte2 <= in;
            end
            2: begin
                if (in[3] == 1) begin
                    state <= 1;
                    done <= 1;
                end else 
                    state <= 0;
                
                byte3 <= in;
            end
        endcase
    end
end

assign done = 0;

endmodule
