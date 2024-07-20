module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack
);

localparam [1:0] SEARCH = 2'd0, 
                 SHIFT  = 2'd1, 
                 WAIT   = 2'd2, 
                 NOTIFY = 2'd3;

reg [1:0] state, next_state;
reg [3:0] bit_count;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= SEARCH;
        shift_ena <= 1'b0;
        counting <= 1'b0;
        done <= 1'b0;
        bit_count <= 4'b0;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    next_state = state;
    case (state)
        SEARCH: begin
            if (data == 1'b1 && bit_count == 4'd0) bit_count <= 4'd1;
            else if (data == 1'b1 && bit_count == 4'd1) bit_count <= 4'd2;
            else if (data == 1'b0 && bit_count == 4'd2) bit_count <= 4'd3;
            else if (data == 1'b1 && bit_count == 4'd3) begin
                next_state = SHIFT;
                bit_count <= 4'b0;
            end
            else bit_count <= 4'b0;
            
            shift_ena <= 1'b0;
            counting <= 1'b0;
            done <= 1'b0;
        end
        
        SHIFT: begin
            if (bit_count < 4'd4) begin
                bit_count <= bit_count + 4'd1;
                shift_ena <= 1'b1;
            end
            else begin
                next_state = WAIT;
                bit_count <= 4'b0;
                shift_ena <= 1'b0;
            end
            
            counting <= 1'b0;
            done <= 1'b0;
        end
        
        WAIT: begin
            if (done_counting) begin
                next_state = NOTIFY;
            end
            
            shift_ena <= 1'b0;
            counting <= 1'b1;
            done <= 1'b0;
        end
        
        NOTIFY: begin
            if (ack) begin
                next_state = SEARCH;
            end
            
            shift_ena <= 1'b0;
            counting <= 1'b0;
            done <= 1'b1;
        end
    endcase
end

endmodule
