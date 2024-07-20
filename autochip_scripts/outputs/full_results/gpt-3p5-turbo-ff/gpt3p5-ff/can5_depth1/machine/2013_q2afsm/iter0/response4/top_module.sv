module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);

reg [1:0] state;
reg [1:0] next;

always @(posedge clk) begin
    if (!resetn) begin
        state <= 2'b00;
    end else begin
        state <= next;
    end
end

always @(*) begin
    case (state)
        2'b00: begin
            if (r[3]) begin
                next = 2'b11;
            end else if (r[2]) begin
                next = 2'b10;
            end else if (r[1]) begin
                next = 2'b01;
            end else begin
                next = 2'b00;
            end
        end
        
        2'b01: begin
            if (r[1]) begin
                next = 2'b01;
            end else begin
                next = 2'b00;
            end
        end
        
        2'b10: begin
            if (r[2]) begin
                next = 2'b10;
            end else begin
                next = 2'b00;
            end
        end
        
        2'b11: begin
            if (r[3]) begin
                next = 2'b11;
            end else begin
                next = 2'b00;
            end
        end
    endcase
end

always @(*) begin
    case (state)
        2'b00: begin
            g[3] = (state == 2'b11);
            g[2] = (state == 2'b10);
            g[1] = (state == 2'b01);
        end
        
        2'b01: begin
            g[3] = 1'b0;
            g[2] = 1'b0;
            g[1] = 1'b1;
        end
        
        2'b10: begin
            g[3] = 1'b0;
            g[2] = 1'b1;
            g[1] = 1'b0;
        end
        
        2'b11: begin
            g[3] = 1'b1;
            g[2] = 1'b0;
            g[1] = 1'b0;
        end
    endcase
end

endmodule
