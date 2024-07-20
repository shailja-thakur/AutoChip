module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    reg [1:0] state;
    reg [1:0] count;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 2'b00;
            count <= 2'b00;
            z <= 0;
        end else begin
            case(state)
                2'b00: begin
                    if (s == 1'b0) begin
                        state <= 2'b00;
                        count <= 2'b00;
                        z <= 0;
                    end else if (s == 1'b1) begin
                        state <= 2'b01;
                        count <= 2'b00;
                        z <= 0;
                    end
                end
                2'b01: begin
                    if (w == 1'b1) begin
                        count <= count + 1;
                    end
                    
                    if (count == 2'b10) begin
                        state <= 2'b10;
                        count <= 2'b00;
                        z <= 1;
                    end else begin
                        state <= 2'b01;
                    end
                end
                2'b10: begin
                    state <= 2'b00;
                    count <= 2'b00;
                    z <= 0;
                end
            endcase
        end
    end
    
endmodule
