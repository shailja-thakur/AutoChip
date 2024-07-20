module top_module (
    input clk,
    input resetn,
    input [2:0] r,
    output reg [2:0] g
);

reg [1:0] state, next;

always @(posedge clk) begin
    if(!resetn)
        state <= 2'd0; // State A
    else
        state <= next;
end

always @(*) begin
    case (state)
        2'd0: begin // State A
            if(r[0])
                next = 2'd1; // State B
            else if(r[1])
                next = 2'd2; // State C
            else if(r[2])
                next = 2'd3; // State D
            else
                next = 2'd0; // State A
        end
        2'd1: begin // State B
            if(r[0])
                next = 2'd1; // State B
            else
                next = 2'd0; // State A
        end
        2'd2: begin // State C
            if(r[1])
                next = 2'd2; // State C
            else
                next = 2'd0; // State A
        end
        2'd3: begin // State D
            if(r[2])
                next = 2'd3; // State D
            else
                next = 2'd0; // State A
        end
        default:
            next = 2'd0; // State A
    endcase
end

always @(*) begin
    g = 3'd0;
    case (state)
        2'd1: g[0] = 1'b1; // State B
        2'd2: g[1] = 1'b1; // State C
        2'd3: g[2] = 1'b1; // State D
    endcase
end

endmodule
