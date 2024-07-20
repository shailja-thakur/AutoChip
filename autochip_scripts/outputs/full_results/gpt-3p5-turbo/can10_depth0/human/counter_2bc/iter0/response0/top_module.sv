module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    logic [1:0] counter;

    always @(posedge clk, posedge areset) begin
        if (areset) begin
            counter <= 2'b01;
        end else if (train_valid) begin
            if (train_taken && counter != 2'b11) begin
                counter <= counter + 1;
            end else if (!train_taken && counter != 2'b00) begin
                counter <= counter - 1;
            end
        end
    end
    
    assign state = counter;
    
endmodule
