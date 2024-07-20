module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output reg [3:1] g
);

reg [3:1] state;
reg [3:1] next;

always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        state <= 3'b001;
    end else begin
        state <= next;
    end
end

always @* begin
    case(state)
        3'b001: begin
            if (r[1]) begin
                next = 3'b010;
            end else if (r[2]) begin
                next = 3'b011;
            end else if (r[3]) begin
                next = 3'b100;
            end else begin
                next = 3'b001;
            end
        end
        
        3'b010: begin
            if (r[1]) begin
                next = 3'b010;
            end else begin
                next = 3'b001;
            end
        end
        
        3'b011: begin
            if (r[2]) begin
                next = 3'b011;
            end else begin
                next = 3'b001;
            end
        end
        
        3'b100: begin
            if (r[3]) begin
                next = 3'b100;
            end else begin
                next = 3'b001;
            end
        end
    endcase
end

always @(posedge clk) begin
    case(state)
        3'b010: begin
            g[1] <= 1'b1;
            g[2] <= 1'b0;
            g[3] <= 1'b0;
        end
        
        3'b011: begin
            g[1] <= 1'b0;
            g[2] <= 1'b1;
            g[3] <= 1'b0;
        end
        
        3'b100: begin
            g[1] <= 1'b0;
            g[2] <= 1'b0;
            g[3] <= 1'b1;
        end
        
        default: begin
            g[1] <= 1'b0;
            g[2] <= 1'b0;
            g[3] <= 1'b0;
        end
    endcase
end

endmodule
