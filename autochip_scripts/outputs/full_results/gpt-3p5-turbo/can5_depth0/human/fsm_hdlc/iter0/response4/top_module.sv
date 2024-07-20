module top_module(
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);
    
    reg [2:0] state;
    reg [2:0] next_state;
    
    // Default initialization
    initial begin
        state = 3'b000;
    end
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b000;
        end else begin
            state <= next_state;
        end
    end
    
    always @(state or in) begin
        disc = 1'b0;
        flag = 1'b0;
        err = 1'b0;
        
        // Next state logic
        case (state)
            3'b000: begin  // State 0
                if (in) begin
                    next_state = 3'b001;
                end else begin
                    next_state = 3'b000;
                end
            end
            
            3'b001: begin  // State 1
                if (in) begin
                    next_state = 3'b010;
                end else begin
                    next_state = 3'b000;
                end
            end
            
            3'b010: begin  // State 2
                if (in) begin
                    next_state = 3'b011;
                end else begin
                    next_state = 3'b000;
                end
            end
            
            3'b011: begin  // State 3
                if (in) begin
                    next_state = 3'b100;
                    disc = 1'b1;
                end else begin
                    next_state = 3'b101;
                    flag = 1'b1;
                end
            end
            
            3'b100: begin  // State 4
                if (in) begin
                    next_state = 3'b101;
                    flag = 1'b1;
                end else begin
                    next_state = 3'b110;
                end
            end
            
            3'b101: begin  // State 5
                if (in) begin
                    next_state = 3'b110;
                end else begin
                    next_state = 3'b000;
                end
            end
            
            3'b110: begin  // State 6
                if (in) begin
                    next_state = 3'b110;
                    err = 1'b1;
                end else begin
                    next_state = 3'b000;
                end
            end
        endcase
    end
endmodule
