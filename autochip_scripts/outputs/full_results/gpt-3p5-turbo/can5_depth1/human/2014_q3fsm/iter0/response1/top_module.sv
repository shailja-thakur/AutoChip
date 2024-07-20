module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [1:0] state;
reg [2:0] w_count;

parameter A = 2'b00;
parameter B = 2'b01;

always @(posedge clk) begin
    if (reset) begin
        state <= A;
        z <= 0;
        w_count <= 0;
    end else begin
        case (state)
            A: begin
                if (s == 1) begin
                    state <= B;
                    w_count <= 0;
                end
            end
            
            B: begin
                if (w == 1) begin
                    w_count <= w_count + 1;
                end
                
                if (w_count == 2) begin
                    state <= A;
                    z <= 1;
                    w_count <= 0;
                end else if (w_count > 2) begin
                    state <= A;
                    z <= 0;
                    w_count <= 0;
                end
            end
            
            default: begin
                state <= A;
                z <= 0;
                w_count <= 0;
            end
        endcase
    end
end

endmodule
