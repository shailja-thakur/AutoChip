module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);
    reg [1:0] state;
    reg [2:0] count;
    
    always @(posedge clk or negedge resetn) begin
        if (~resetn) begin
            state <= 2'b00; // state A
            f <= 1'b0;
            g <= 1'b0;
        end else begin
            case (state)
                2'b00: begin // state A
                    f <= 1'b0;
                    g <= 1'b0;
                    if (x) begin
                        state <= 2'b01; // state B
                        count <= 3'b000;
                    end
                end
                
                2'b01: begin // state B
                    f <= 1'b1;
                    g <= 1'b0;
                    if (count == 3'b101) begin
                        state <= 2'b10; // state C
                        count <= 0;
                    end else if (x) begin
                        count <= count + 1;
                    end
                end
                
                2'b10: begin // state C
                    f <= 1'b1;
                    g <= 1'b0;
                    if (y) begin
                        state <= 2'b11; // state D
                        count <= 0;
                    end else if (count == 3'b010) begin
                        state <= 2'b01; // state B
                        count <= 3'b000;
                    end else begin
                        count <= count + 1;
                    end
                end
                
                2'b11: begin // state D
                    f <= 1'b1;
                    g <= 1'b1;
                    if (y) begin
                        state <= 2'b11; // state D
                    end else begin
                        state <= 2'b10; // state C
                        count <= 0;
                    end
                end
            endcase
        end
    end
endmodule
