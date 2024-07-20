module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output f,
    output g
);

    reg [1:0] state;
    wire x_valid;
    wire y_valid;
    
    // State Definition
    parameter A = 2'b00;
    parameter WAIT_FOR_X = 2'b01;
    parameter WAIT_FOR_Y = 2'b10;
    
    // Combinational logic for x and y validation
    assign x_valid = (state == WAIT_FOR_X) ? (x == 1'b1) : 1'b0;
    assign y_valid = (state == WAIT_FOR_Y) ? (y == 1'b1) : 1'b0;
    
    always @(posedge clk or negedge resetn) begin
        if (~resetn) begin
            state <= A;
            f <= 1'b0;
            g <= 1'b0;
        end
        else begin
            case (state)
                A: begin // Initial state
                    if (resetn == 1'b0)
                        state <= A;
                    else if (resetn == 1'b1)
                        state <= WAIT_FOR_X;
                end
                
                WAIT_FOR_X: begin
                    if (resetn == 1'b0)
                        state <= A;
                    else if (x_valid && (x == 1'b0))
                        state <= WAIT_FOR_Y;
                    else
                        state <= WAIT_FOR_X;
                end
                
                WAIT_FOR_Y: begin
                    if (resetn == 1'b0)
                        state <= A;
                    else if (y_valid && (y == 1'b1))
                        state <= WAIT_FOR_Y;
                    else if (~y_valid || (y_valid && (y == 1'b0)) || (y_valid && (y == 1'b1)))
                        state <= A;
                end
            endcase
        end
    end

    always @(posedge clk or negedge resetn) begin
        if (~resetn) begin
            f <= 1'b0;
        end
        else begin
            case (state)
                A: begin // Initial state
                    if (resetn == 1'b0)
                        f <= 1'b0;
                    else if (resetn == 1'b1) begin
                        f <= 1'b1;
                    end
                end
                
                WAIT_FOR_X: begin
                    if (resetn == 1'b0)
                        f <= 1'b0;
                    else if (resetn == 1'b1) begin
                        f <= 1'b0;
                    end
                end
                
                WAIT_FOR_Y: begin
                    if (resetn == 1'b0)
                        f <= 1'b0;
                    else if (resetn == 1'b1) begin
                        f <= 1'b0;
                    end
                end
            endcase
        end
    end
    
    always @(posedge clk or negedge resetn) begin
        if (~resetn) begin
            g <= 1'b0;
        end
        else begin
            case (state)
                A: begin // Initial state
                    if (resetn == 1'b0)
                        g <= 1'b0;
                    else if (resetn == 1'b1) begin
                        g <= 1'b0;
                    end
                end
                
                WAIT_FOR_X: begin
                    if (resetn == 1'b0)
                        g <= 1'b0;
                    else if (resetn == 1'b1) begin
                        g <= 1'b0;
                    end
                end
                
                WAIT_FOR_Y: begin
                    if (resetn == 1'b0)
                        g <= 1'b0;
                    else if (resetn == 1'b1) begin
                        g <= (y_valid && (y == 1'b1)) ? 1'b1 : 1'b0;
                    end
                end
            endcase
        end
    end
    
endmodule
