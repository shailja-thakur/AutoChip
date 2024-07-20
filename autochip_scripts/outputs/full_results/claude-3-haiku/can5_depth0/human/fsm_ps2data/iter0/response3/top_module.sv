module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

localparam [1:0] 
    ST_SEARCH = 2'd0,
    ST_RECEIVE = 2'd1,
    ST_DONE = 2'd2;

reg [1:0] state, next_state;
reg [2:0] byte_count;

always @(posedge clk) begin
    if (reset) begin
        state <= ST_SEARCH;
        byte_count <= 3'd0;
        out_bytes <= 24'b0;
        done <= 1'b0;
    end
    else begin
        state <= next_state;
        
        case (state)
            ST_SEARCH: begin
                if (in[3]) begin
                    next_state <= ST_RECEIVE;
                    byte_count <= 3'd1;
                    out_bytes[23:16] <= in;
                end
                else begin
                    next_state <= ST_SEARCH;
                    byte_count <= 3'd0;
                    out_bytes <= 24'b0;
                end
            end
            ST_RECEIVE: begin
                out_bytes[15:8] <= in;
                byte_count <= byte_count + 3'd1;
                
                if (byte_count == 3'd2) begin
                    next_state <= ST_DONE;
                end
                else begin
                    next_state <= ST_RECEIVE;
                end
            end
            ST_DONE: begin
                out_bytes[7:0] <= in;
                done <= 1'b1;
                next_state <= ST_SEARCH;
                byte_count <= 3'd0;
            end
        endcase
    end
end

endmodule
