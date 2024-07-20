module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);
    reg [1:0] state, next_state;
    reg [1:0] count;
    
    localparam A = 2'd0, 
               B = 2'd1, 
               B1 = 2'd2, 
               B2 = 2'd3;
    
    // State transition on clock edge
    always @(posedge clk) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end
    
    // Next state logic
    always @(*) begin
        case (state)
            A: begin
                if (s == 1'b1)
                    next_state = B;
                else
                    next_state = A;
            end
            B: next_state = B1;
            B1: next_state = B2;
            B2: next_state = B;
            default: next_state = A;
        endcase
    end
    
    // Output and counter logic
    always @(posedge clk) begin
        if (reset) begin
            z <= 1'b0;
            count <= 2'd0;
        end 
        else begin
            case (state)
                A: begin
                    z <= 1'b0;
                    count <= 2'd0;
                end
                B: begin
                    z <= 1'b0;
                    count <= w;
                end
                B1: begin
                    count <= count + w;
                end
                B2: begin
                    count <= count + w;
                    if (count + w == 2)
                        z <= 1'b1;
                    else
                        z <= 1'b0;
                end
            endcase
        end
    end
endmodule
