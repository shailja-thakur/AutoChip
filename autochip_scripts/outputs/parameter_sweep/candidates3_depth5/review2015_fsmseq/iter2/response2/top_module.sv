module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);
    
    reg [3:0] state;
    reg [3:0] next_state;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 4'b0000;
            start_shifting <= 0;
        end else begin
            state <= next_state;
        end
    end
    
    always @(state or data) begin
        case (state)
            4'b0000: begin
                if (data) begin
                    next_state <= 4'b0001;
                end else begin
                    next_state <= 4'b0000;
                end
            end
            4'b0001: begin
                if (data) begin
                    next_state <= 4'b0010;
                end else begin
                    next_state <= 4'b0000;
                end
            end
            4'b0010: begin
                if (data) begin
                    next_state <= 4'b0011;
                end else begin
                    next_state <= 4'b0000;
                end
            end
            4'b0011: begin
                if (data) begin
                    next_state <= 4'b0100;
                end else begin
                    next_state <= 4'b0000;
                end
            end
            4'b0100: begin
                if (data) begin
                    next_state <= 4'b0101;
                end else begin
                    next_state <= 4'b0000;
                end
            end
            4'b0101: begin
                if (data) begin
                    next_state <= 4'b0110;
                end else begin
                    next_state <= 4'b0000;
                end
            end
            4'b0110: begin
                if (data) begin
                    next_state <= 4'b0111;
                end else begin
                    next_state <= 4'b0000;
                end
            end
            4'b0111: begin
                if (data) begin
                    next_state <= 4'b1000;
                end else begin
                    next_state <= 4'b0000;
                end
            end
            4'b1000: begin
                if (data) begin
                    next_state <= 4'b1001;
                end else begin
                    next_state <= 4'b0000;
                end
            end
            4'b1001: begin
                if (data) begin
                    next_state <= 4'b1010;
                end else begin
                    next_state <= 4'b0000;
                end
            end
            4'b1010: begin
                if (data) begin
                    next_state <= 4'b1011;
                end else begin
                    next_state <= 4'b0000;
                end
            end
            4'b1011: begin
                if (data) begin
                    next_state <= 4'b1100;
                end else begin
                    next_state <= 4'b0000;
                end
            end
            4'b1100: begin
                if (data) begin
                    next_state <= 4'b1101;
                end else begin
                    next_state <= 4'b0000;
                end
            end
            4'b1101: begin
                if (data) begin
                    next_state <= 4'b1101;
                end else begin
                    next_state <= 4'b0000;
                    start_shifting <= 1;
                end
            end
        endcase
    end
    
endmodule
